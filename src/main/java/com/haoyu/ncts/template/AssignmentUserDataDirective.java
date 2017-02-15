package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Component;

import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.assignment.entity.Assignment;
import com.haoyu.aip.assignment.entity.AssignmentRelation;
import com.haoyu.aip.assignment.entity.AssignmentUser;
import com.haoyu.aip.assignment.service.IAssignmentRelationService;
import com.haoyu.aip.assignment.service.IAssignmentService;
import com.haoyu.aip.assignment.service.IAssignmentUserService;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.RoleCodeConstant;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class AssignmentUserDataDirective implements TemplateDirectiveModel {

	@Resource
	private IAssignmentService assignmentService;
	@Resource
	private IAssignmentUserService assignmentUserService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IActivityService activityService;
	@Resource
	private IAssignmentRelationService assignmentRelationService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Subject currentUser = SecurityUtils.getSubject();
		if(params.containsKey("assignmentId") && params.containsKey("relationId")){
			String assignmentId = params.get("assignmentId").toString();
			String relationId = params.get("relationId").toString();
			String assignmentRelationId = AssignmentRelation.getId(assignmentId, relationId);
			Assignment assignment = assignmentService.getAssignment(assignmentId);
			if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
				AssignmentUser assignmentUser = assignmentUserService.createAssignmentIfNotExists(assignmentRelationId);
				assignmentUser.getAssignmentRelation().setAssignment(assignment);
				env.setVariable("assignmentUser", new DefaultObjectWrapper().wrap(assignmentUser));
			}else{
				AssignmentRelation assignmentRelation = assignmentRelationService.getAssignmentRelation(assignmentRelationId);
				assignmentRelation.setAssignment(assignment);
				env.setVariable("assignmentRelation", new DefaultObjectWrapper().wrap(assignmentRelation));
			}
			
			if(params.containsKey("activityId")){
				String activityId = params.get("activityId").toString();
				if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
					ActivityResult activityResult = activityResultService.createIfNotExists(activityId, relationId);
					env.setVariable("activityResult", new DefaultObjectWrapper().wrap(activityResult));
				}
				env.setVariable("activity", new DefaultObjectWrapper().wrap(activityService.getActivity(activityId)));
			}
		}else if (params.containsKey("id")) {
			String id = params.get("id").toString();
			AssignmentUser assignmentUser = assignmentUserService.getAssignmentUser(id);
			env.setVariable("assignmentUser", new DefaultObjectWrapper().wrap(assignmentUser));
		}
		body.render(env.getOut());
	}
	
}
