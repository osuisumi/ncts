package com.haoyu.ncts.attitude.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.haoyu.aip.discussion.service.IDiscussionPostService;
import com.haoyu.aip.discussion.service.IDiscussionRelationService;
import com.haoyu.aip.discussion.service.IDiscussionService;
import com.haoyu.sip.attitude.entity.AttitudeUser;
import com.haoyu.sip.attitude.event.CreateAttitudeUserEvent;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceRelationService;
import com.haoyu.tip.resource.service.IResourceService;

@Component
public class CreateAttitudeListener implements ApplicationListener<CreateAttitudeUserEvent>{
	@Resource
	private IResourceService resourceService;
	@Resource
	private IDiscussionService DiscussionService;
	@Resource
	private IDiscussionRelationService discussionRelationService;
	@Resource
	private IDiscussionPostService discussionPostService;
	@Resource
	private IResourceRelationService resourceRelationService;

	@Override
	public void onApplicationEvent(CreateAttitudeUserEvent event) {
		AttitudeUser attitudeUser = (AttitudeUser) event.getSource();
		if(!StringUtils.isEmpty(attitudeUser.getRelation().getType())){
			if (attitudeUser.getRelation().getType().equals("discovery")) {
				Resources discovery = resourceService.get(attitudeUser.getRelation().getId());
				ResourceRelation rr = new ResourceRelation();
				rr.setId(discovery.getResourceRelations().get(0).getId());
				rr.setSupportNum(1);
				resourceRelationService.update(rr);
			}else if (attitudeUser.getRelation().getType().equals("resource")) {
				Resources resources = resourceService.get(attitudeUser.getRelation().getId());
				ResourceRelation rr = new ResourceRelation();
				rr.setId(resources.getResourceRelations().get(0).getId());
				rr.setSupportNum(1);
				resourceRelationService.update(rr);
			}else if(attitudeUser.getRelation().getType().equals("competition")){
				Resources resources = resourceService.get(attitudeUser.getRelation().getId());
				ResourceRelation rr = new ResourceRelation();
				rr.setId(resources.getResourceRelations().get(0).getId());
				rr.setVoteNum(1);
				resourceRelationService.update(rr);
			}
		}
	}
}
