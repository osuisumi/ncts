package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.service.IDiscussionPostService;
import com.haoyu.aip.discussion.service.IDiscussionService;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.RoleCodeConstant;
import com.haoyu.sip.tag.entity.Tag;
import com.haoyu.sip.tag.service.ITagService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class DiscussionUserDataDirective implements TemplateDirectiveModel {

	@Resource
	private IDiscussionService discussionService;
	@Resource
	private IDiscussionPostService discussionPostService;
	@Resource
	private ITagService tagService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IActivityService activityService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		if(params.containsKey("discussionId")){
			String discussionId = params.get("discussionId").toString();
			String relationId = params.get("relationId").toString();
			Discussion discussion = discussionService.viewDiscussion(discussionId);
			if (discussion != null) {
				env.setVariable("discussion", new DefaultObjectWrapper().wrap(discussion));
			}else{
				env.setVariable("discussion", new DefaultObjectWrapper().wrap(new Discussion()));
			}
//			PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
//			SearchParam searchParam = new SearchParam();
//			searchParam.getParamMap().put("discussionRelationId", discussion.getDiscussionRelations().get(0).getId());
//			List<DiscussionPost> discussionPosts = discussionPostService.list(searchParam, pageBounds);
//			env.setVariable("discussionPosts", new DefaultObjectWrapper().wrap(discussionPosts));
//			if (pageBounds != null && pageBounds.isContainsTotalCount()) {
//				PageList pageList = (PageList)discussionPosts;
//				env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
//			}
			
			if(params.containsKey("activityId")){
				String activityId = params.get("activityId").toString();
				Subject currentUser = SecurityUtils.getSubject();
				if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
					ActivityResult activityResult = activityResultService.createIfNotExists(activityId, relationId);
					env.setVariable("activityResult", new DefaultObjectWrapper().wrap(activityResult));
				}
				env.setVariable("activity", new DefaultObjectWrapper().wrap(activityService.getActivity(activityId)));
				
				List<Tag> tags = tagService.findTagByNameAndRelations(null, Lists.newArrayList(activityId), null);
				env.setVariable("tags", new DefaultObjectWrapper().wrap(tags));
			}
		}
		body.render(env.getOut());
	}

}
