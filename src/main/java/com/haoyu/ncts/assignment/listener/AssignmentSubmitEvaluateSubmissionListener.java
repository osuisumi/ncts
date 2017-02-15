package com.haoyu.ncts.assignment.listener;

import java.math.BigDecimal;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.aip.assignment.entity.Assignment;
import com.haoyu.aip.assignment.entity.AssignmentMark;
import com.haoyu.aip.assignment.entity.AssignmentUser;
import com.haoyu.aip.assignment.service.IAssignmentMarkService;
import com.haoyu.aip.assignment.service.IAssignmentUserService;
import com.haoyu.aip.assignment.utils.AssignmentMarkState;
import com.haoyu.aip.assignment.utils.AssignmentMarkType;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.evaluate.event.SubmitEvaluateSubmissionEvent;

@Component
public class AssignmentSubmitEvaluateSubmissionListener implements ApplicationListener<SubmitEvaluateSubmissionEvent>{
	
	@Resource
	private IAssignmentMarkService assignmentMarkService;
	@Resource
	private IAssignmentUserService assignmentUserService;

	@Override
	public void onApplicationEvent(SubmitEvaluateSubmissionEvent event) {
		Map<String, Object> source = (Map<String, Object>) event.getSource();
		String assignmentUserId = (String) source.get("relationId");
		BigDecimal score = (BigDecimal) source.get("score");
		AssignmentUser assignmentUser = assignmentUserService.getAssignmentUser(assignmentUserId);
		Assignment assignment = assignmentUser.getAssignmentRelation().getAssignment();
		String assignmentMarkId = AssignmentMark.getId(assignmentUserId, ThreadContext.getUser().getId());
		
		AssignmentMark assignmentMark = new AssignmentMark();
		assignmentMark.setId(assignmentMarkId);
		assignmentMark.setAssignmentUser(assignmentUser);
		//20是页面决定的
		BigDecimal pct = BigDecimal.valueOf(0);
		if (AssignmentMarkType.EACH_OTHER.equals(assignment.getMarkType())) {
			pct = assignment.getEachOtherMarkConfig().getMarkScorePct();
			if (pct == null) {
				pct = BigDecimal.valueOf(0);
			}
		}
		score = score.multiply(BigDecimal.valueOf(20))
				.multiply(assignmentUser.getAssignmentRelation().getAssignment().getScore()==null?BigDecimal.valueOf(100):assignmentUser.getAssignmentRelation().getAssignment().getScore())
				.multiply(BigDecimal.valueOf(100).subtract(pct))
				.divide(BigDecimal.valueOf(100), 1, BigDecimal.ROUND_HALF_UP)
				.divide(BigDecimal.valueOf(100), 1, BigDecimal.ROUND_HALF_UP);
		assignmentMark.setScore(score);
		assignmentMark.setState(AssignmentMarkState.MARKED);
		assignmentMarkService.updateAssignmentMark(assignmentMark);
		
	}
}
