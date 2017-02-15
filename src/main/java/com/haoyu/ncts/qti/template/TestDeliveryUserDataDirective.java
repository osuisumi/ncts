/**
 * 
 */
package com.haoyu.ncts.qti.template;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import uk.ac.ed.ph.jqtiplus.SimpleJqtiFacade;
import uk.ac.ed.ph.jqtiplus.node.item.AssessmentItem;
import uk.ac.ed.ph.jqtiplus.node.result.AssessmentResult;
import uk.ac.ed.ph.jqtiplus.node.result.ItemResult;
import uk.ac.ed.ph.jqtiplus.resolution.ResolvedAssessmentItem;
import uk.ac.ed.ph.jqtiplus.state.TestPlan;
import uk.ac.ed.ph.jqtiplus.state.TestPlanNode;
import uk.ac.ed.ph.jqtiplus.state.TestPlanNode.TestNodeType;
import uk.ac.ed.ph.jqtiplus.state.TestSessionState;
import uk.ac.ed.ph.jqtiplus.utils.contentpackaging.QtiContentPackageExtractor;
import uk.ac.ed.ph.jqtiplus.xmlutils.CustomUriScheme;
import uk.ac.ed.ph.jqtiplus.xmlutils.locators.FileResourceLocator;
import uk.ac.ed.ph.jqtiplus.xmlutils.locators.FileSandboxResourceLocator;
import uk.ac.ed.ph.jqtiplus.xmlutils.locators.ResourceLocator;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.qti.dao.ITestDeliveryDao;
import com.haoyu.aip.qti.entity.MultipleChoiceQuestion;
import com.haoyu.aip.qti.entity.Question;
import com.haoyu.aip.qti.entity.QuestionType;
import com.haoyu.aip.qti.entity.SingleChoiceQuestion;
import com.haoyu.aip.qti.entity.TestDelivery;
import com.haoyu.aip.qti.entity.TestDeliveryUser;
import com.haoyu.aip.qti.entity.TestPackage;
import com.haoyu.aip.qti.entity.TestSubmission;
import com.haoyu.aip.qti.entity.TrueFalseQuestion;
import com.haoyu.aip.qti.service.ITestDeliveryUserService;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.utils.ThreadContext;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

/**
 * @author lianghuahuang
 *
 */
@Component
public class TestDeliveryUserDataDirective implements TemplateDirectiveModel {
	@Resource
	private ITestDeliveryUserService testDeliveryUserService;
	
	@Resource
	private ITestDeliveryDao testDeliveryDao;
	
	@Resource
	private IActivityService activityService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		if(params.containsKey("testId")&& params.containsKey("relationId")){
			String relationId = params.get("relationId").toString();
			String testId = params.get("testId").toString();
			TestDelivery testDelivery  =testDeliveryDao.selectTestDelivery(testId,relationId);
			User deliveryUser = ThreadContext.getUser();
			TestDeliveryUser testDeliveryUser = new TestDeliveryUser();
			testDeliveryUser.setTestDelivery(testDelivery);
			testDeliveryUser.setDeliveryUser(deliveryUser);
			AssessmentResult assessmentResult = testDeliveryUserService.enterOrReenterTestDeliveryUser(testDeliveryUser);
			//testDeliveryUser.setId(testDeliveryUser.getId());
			
			TestPackage testPackage = testDeliveryUser.getTestDelivery().getTest().getTestPackage();
			
			List<Question> questions = getQuestions(testDeliveryUser,testPackage.getSandboxPath());
			if(!questions.isEmpty()){
				env.setVariable("questions", new DefaultObjectWrapper().wrap(questions));
			}
			
			if(assessmentResult!=null){
				Map<String,TestSubmission> testSubmissionMap = Maps.newHashMap();
				List<ItemResult> itemResults = assessmentResult.getItemResults();
				for(ItemResult itemResult:itemResults){
					testSubmissionMap.put(itemResult.getIdentifier(), new TestSubmission(itemResult));
				}
				env.setVariable("testSubmissionMap", new DefaultObjectWrapper().wrap(testSubmissionMap));
			}
			env.setVariable("testDeliveryUser", new DefaultObjectWrapper().wrap(testDeliveryUser));
		}
		if (params.containsKey("activityId")) {
			String activityId = params.get("activityId").toString();
			Activity activity = activityService.getActivity(activityId);
			env.setVariable("activity", new DefaultObjectWrapper().wrap(activity));
		}
		body.render(env.getOut());

	}

	/**
	 * @param testDeliveryUser
	 * @return
	 */
	private List<Question> getQuestions(TestDeliveryUser testDeliveryUser,String sandboxPath) {
		TestSessionState testSessionState = testDeliveryUserService.loadTestSessionState(testDeliveryUser);
		TestPlan testPlan = testSessionState.getTestPlan();
		List<TestPlanNode> testPlanNodeList = testPlan.getTestPlanNodeList();
		SimpleJqtiFacade simpleJqtiFacade = new SimpleJqtiFacade();
		List<Question> questions = Lists.newArrayList();
		for(TestPlanNode testPlanNode:testPlanNodeList){
			if(testPlanNode.getTestNodeType().equals(TestNodeType.ASSESSMENT_ITEM_REF)){
				URI uri = testPlanNode.getItemSystemId();
				final File sandboxDirectory = new File(sandboxPath);
	            final CustomUriScheme packageUriScheme = QtiContentPackageExtractor.PACKAGE_URI_SCHEME;
	            final FileSandboxResourceLocator fileSandboxResourceLocator = new FileSandboxResourceLocator(packageUriScheme, sandboxDirectory);
				ResolvedAssessmentItem ra =simpleJqtiFacade.loadAndResolveAssessmentItem(fileSandboxResourceLocator, uri);
				AssessmentItem assessmentItem = ra.getRootNodeLookup().extractIfSuccessful();
				QuestionType questionType  =  Question.getQuesType(assessmentItem);
				switch(questionType){
						case SINGLE_CHOICE:
							Question question =new SingleChoiceQuestion(assessmentItem); 
							question.setId(testPlanNode.getIdentifier().toString());
							question.setItemKey(testPlanNode.getKey().toString());
							questions.add(question);
							break;
						case TRUE_FALSE:
							question =new TrueFalseQuestion(assessmentItem); 
							question.setId(testPlanNode.getIdentifier().toString());
							question.setItemKey(testPlanNode.getKey().toString());
							questions.add(question);
							break;
						case MULTIPLE_CHOICE:
							question =new MultipleChoiceQuestion(assessmentItem); 
							question.setId(testPlanNode.getIdentifier().toString());
							question.setItemKey(testPlanNode.getKey().toString());
							questions.add(question);
							break;
						default:
							break;
				}
			}
		}
		return questions;
	}
	
}
