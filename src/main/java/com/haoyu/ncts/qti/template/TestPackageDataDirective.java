package com.haoyu.ncts.qti.template;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.stereotype.Component;
import org.xml.sax.SAXException;

import uk.ac.ed.ph.jqtiplus.SimpleJqtiFacade;
import uk.ac.ed.ph.jqtiplus.node.RootNode;
import uk.ac.ed.ph.jqtiplus.node.item.AssessmentItem;
import uk.ac.ed.ph.jqtiplus.node.test.AssessmentItemRef;
import uk.ac.ed.ph.jqtiplus.node.test.AssessmentSection;
import uk.ac.ed.ph.jqtiplus.node.test.AssessmentTest;
import uk.ac.ed.ph.jqtiplus.node.test.SectionPart;
import uk.ac.ed.ph.jqtiplus.node.test.TestPart;
import uk.ac.ed.ph.jqtiplus.resolution.ResolvedAssessmentItem;
import uk.ac.ed.ph.jqtiplus.resolution.ResolvedAssessmentTest;
import uk.ac.ed.ph.jqtiplus.types.Identifier;
import uk.ac.ed.ph.jqtiplus.utils.contentpackaging.QtiContentPackageExtractor;
import uk.ac.ed.ph.jqtiplus.xmlutils.CustomUriScheme;
import uk.ac.ed.ph.jqtiplus.xmlutils.locators.FileResourceLocator;
import uk.ac.ed.ph.jqtiplus.xmlutils.locators.FileSandboxResourceLocator;
import uk.ac.ed.ph.jqtiplus.xmlutils.locators.ResourceLocator;

import com.google.common.collect.Lists;
import com.haoyu.aip.qti.entity.MultipleChoiceQuestion;
import com.haoyu.aip.qti.entity.Question;
import com.haoyu.aip.qti.entity.QuestionType;
import com.haoyu.aip.qti.entity.SingleChoiceQuestion;
import com.haoyu.aip.qti.entity.Test;
import com.haoyu.aip.qti.entity.TestPackage;
import com.haoyu.aip.qti.entity.TrueFalseQuestion;
import com.haoyu.aip.qti.service.ITestService;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.ext.dom.NodeModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class TestPackageDataDirective implements TemplateDirectiveModel {

	@Resource
	private ITestService testService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		if (params.containsKey("testPackage")) {
			BeanModel beanModel = (BeanModel) params.get("testPackage");
			if (beanModel != null) {
				TestPackage testPackage = (TestPackage) beanModel.getWrappedObject();
				List<Question> questions = Lists.newArrayList();
				
				ResourceLocator inputResourceLocator = new FileResourceLocator();
				StringBuffer path = new StringBuffer("");
				path.append(testPackage.getSandboxPath()).append("/")
						.append(testPackage.getTestHref());
				File file = new File(path.toString());
				URI inputUri = file.toURI();
				SimpleJqtiFacade simpleJqtiFacade = new SimpleJqtiFacade();
				ResolvedAssessmentTest rat = simpleJqtiFacade
						.loadAndResolveAssessmentTest(inputResourceLocator,
								inputUri);
				AssessmentTest assessmentTest = rat.getRootNodeLookup()
						.extractIfSuccessful();
				List<TestPart> testParts = assessmentTest.getTestParts();
				for(TestPart testPart:testParts){
				    List<AssessmentSection> assessmentSections = testPart.getAssessmentSections();
				    if(assessmentSections!=null&&!assessmentSections.isEmpty()){
				    	 for(AssessmentSection assessmentSection:assessmentSections){
				    			 List<SectionPart> sectionParts= assessmentSection.getSectionParts();
				    			 if(sectionParts!=null&&!sectionParts.isEmpty()){
					    			 for(SectionPart sectionPart:sectionParts){
					    				 if(sectionPart instanceof AssessmentItemRef){
					    					 AssessmentItemRef assessmentItemRef = (AssessmentItemRef)sectionPart;					    					 
					    					 final URI itemHref = assessmentItemRef.getHref();
					    		             if (itemHref!=null) {
										         inputResourceLocator = new FileResourceLocator();
												 path = new StringBuffer("");
												 path.append(testPackage.getSandboxPath()).append("/")
															.append(assessmentItemRef.getHref());
												 file = new File(path.toString());
												 inputUri = file.toURI();
										         
												 ResolvedAssessmentItem ra =simpleJqtiFacade.loadAndResolveAssessmentItem(inputResourceLocator, inputUri);
												 AssessmentItem assessmentItem = ra.getRootNodeLookup().extractIfSuccessful();
												 QuestionType questionType  =  Question.getQuesType(assessmentItem);
												 switch(questionType){
															case SINGLE_CHOICE:
																questions.add(new SingleChoiceQuestion(assessmentItem));
																break;
															case TRUE_FALSE:
																questions.add(new TrueFalseQuestion(assessmentItem));
																break;
															case MULTIPLE_CHOICE:
																questions.add(new MultipleChoiceQuestion(assessmentItem));
																break;
															default:
																break;
													}
													
							    				 }
					    		             }
					    			 }
				    			 }
				    	 }
				     }
				}
				if(!questions.isEmpty()){
					env.setVariable("questions", new DefaultObjectWrapper().wrap(questions));
				}	
				
			}
		}
		body.render(env.getOut());
	}
	
	private URI resolveUri(final RootNode baseObject, final URI href) {
        final URI baseUri = baseObject.getSystemId();
        if (baseUri==null) {
            throw new IllegalStateException("baseObject " + baseObject + " does not have a systemId set, so cannot resolve references against it");
        }
        return baseUri.resolve(href);
    }

}
