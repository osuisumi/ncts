package com.haoyu.ncts.course.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityAttribute;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityAttributeService;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.activity.utils.ActivityAttributeName;
import com.haoyu.aip.activity.utils.ActivityResultState;
import com.haoyu.aip.activity.utils.ActivityType;
import com.haoyu.aip.assignment.entity.Assignment;
import com.haoyu.aip.assignment.entity.AssignmentRelation;
import com.haoyu.aip.assignment.service.IAssignmentRelationService;
import com.haoyu.aip.assignment.service.IAssignmentService;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionPost;
import com.haoyu.aip.discussion.entity.DiscussionRelation;
import com.haoyu.aip.discussion.entity.DiscussionUser;
import com.haoyu.aip.discussion.service.IDiscussionPostService;
import com.haoyu.aip.discussion.service.IDiscussionRelationService;
import com.haoyu.aip.discussion.service.IDiscussionService;
import com.haoyu.aip.discussion.service.IDiscussionUserService;
import com.haoyu.aip.qti.entity.Question;
import com.haoyu.aip.qti.entity.QuestionFormKey;
import com.haoyu.aip.qti.entity.Test;
import com.haoyu.aip.qti.entity.TestDelivery;
import com.haoyu.aip.qti.service.IQuestionService;
import com.haoyu.aip.qti.service.ITestService;
import com.haoyu.aip.survey.entity.Survey;
import com.haoyu.aip.survey.entity.SurveyQuestion;
import com.haoyu.aip.survey.entity.SurveyRelation;
import com.haoyu.aip.survey.service.ISurveyQuestionService;
import com.haoyu.aip.survey.service.ISurveyService;
import com.haoyu.aip.text.entity.TextInfo;
import com.haoyu.aip.text.entity.TextInfoFile;
import com.haoyu.aip.text.entity.TextInfoRelation;
import com.haoyu.aip.text.service.ITextInfoFileService;
import com.haoyu.aip.text.service.ITextInfoService;
import com.haoyu.aip.text.utils.TextInfoType;
import com.haoyu.aip.video.entity.Video;
import com.haoyu.aip.video.entity.VideoRelation;
import com.haoyu.aip.video.service.IVideoService;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.service.IActivityBizService;
import com.haoyu.ncts.course.service.ICourseResultBizService;
import com.haoyu.ncts.course.service.ICourseResultService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.utils.CourseType;
import com.haoyu.ncts.course.web.param.ActivityParam;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.mapper.JsonMapper;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.evaluate.entity.Evaluate;
import com.haoyu.sip.evaluate.entity.EvaluateItem;
import com.haoyu.sip.evaluate.entity.EvaluateRelation;
import com.haoyu.sip.evaluate.service.IEvaluateItemService;
import com.haoyu.sip.evaluate.service.IEvaluateRelationService;
import com.haoyu.sip.evaluate.service.IEvaluateService;
import com.haoyu.sip.file.entity.FileInfo;
import com.haoyu.sip.file.entity.FileRelation;
import com.haoyu.sip.file.service.IFileRelationService;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.sip.tag.entity.Tag;
import com.haoyu.sip.tag.entity.TagRelation;
import com.haoyu.sip.tag.service.ITagRelationService;
import com.haoyu.sip.tag.service.ITagService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;

@Service
public class ActivityBizServiceImpl implements IActivityBizService{
	
	@Resource
	private IDiscussionService discussionService;
	@Resource
	private IAssignmentService assignmentService;
	@Resource
	private ITextInfoService textInfoService;
	@Resource
	private IVideoService videoService;
	@Resource
	private IActivityService activityService;
	@Resource
	private ISurveyService surveyService;
	@Resource
	private ITestService testService;
	@Resource
	private IDiscussionPostService discussionPostService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IActivityAttributeService activityAttributeService;
	@Resource
	private IFileService fileService;
	@Resource
	private IFileRelationService fileRelationService;
	@Resource
	private ITagService tagService;
	@Resource
	private ITagRelationService tagRelationService;
	@Resource
	private ISurveyQuestionService surveyQuestionService;
	@Resource
	private IQuestionService questionService;
	@Resource
	private IEvaluateRelationService evaluateRelationService;
	@Resource
	private IEvaluateService evaluateService;
	@Resource
	private IEvaluateItemService evaluateItemService;
	@Resource
	private IAssignmentRelationService assignmentRelationService;
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseResultService courseResultService;
	@Resource
	private ITextInfoFileService textInfoFileService;
	@Resource
	private ICourseResultBizService courseResultBizService;
	@Resource
	private IDiscussionUserService discussionUserService;
	@Resource
	private IDiscussionRelationService discussionRelationService;
	
	@Override
	public Response createActivity(ActivityParam activityParam) {
		Activity activity = activityParam.getActivity();
		String type = activity.getType();
		Response response = null;
		if (ActivityType.DISCUSSION.equals(type)) {
			Discussion discussion = activityParam.getDiscussion();
			activity.setTitle(discussion.getTitle());
			response = discussionService.createDiscussion(discussion);
			activity.setEntityId(discussion.getId());
		}else if(ActivityType.VIDEO.equals(type)){
			Video video = activityParam.getVideo();
			activity.setTitle(video.getTitle());
			response = videoService.createVideo(video);
			activity.setEntityId(video.getId());
		}else if(ActivityType.HTML.equals(type)){
			TextInfo textInfo = activityParam.getTextInfo();
			activity.setTitle(textInfo.getTitle());
			response = textInfoService.createTextInfo(textInfo);
			activity.setEntityId(textInfo.getId());
		}else if(ActivityType.ASSIGNMENT.equals(type)){
			Assignment assignment = activityParam.getAssignment();
			activity.setTitle(assignment.getTitle());
			response = assignmentService.createAssignment(assignment);
			activity.setEntityId(assignment.getId());
		}else if(ActivityType.SURVEY.equals(type)){
			Survey survey = activityParam.getSurvey();
			activity.setTitle(survey.getTitle());
			response = surveyService.createSurvey(survey);
			activity.setEntityId(survey.getId());
		}else if(ActivityType.TEST.equals(type)){
			Test test = activityParam.getTest();
			activity.setTitle(test.getTitle());
			response = testService.createTest(test);
			activity.setEntityId(test.getId());
		}
		if (response.isSuccess()) {
			return activityService.createActivity(activity);
		}
		return Response.failInstance();
	}

	@Override
	public Response updateActivity(ActivityParam activityParam) {
		Activity activity = activityParam.getActivity();
		String type = activity.getType();
		Response response = Response.successInstance();
		if (ActivityType.DISCUSSION.equals(type)) {
			Discussion discussion = activityParam.getDiscussion();
			if (discussion != null) {
				activity.setTitle(discussion.getTitle());
				response = discussionService.updateDiscussion(discussion);
			}
		}else if(ActivityType.VIDEO.equals(type)){
			Video video = activityParam.getVideo();
			if (video != null) {
				activity.setTitle(video.getTitle());
				response = videoService.updateVideo(video);
			}
		}else if(ActivityType.HTML.equals(type)){
			TextInfo textInfo = activityParam.getTextInfo();
			if (textInfo != null) {
				activity.setTitle(textInfo.getTitle());
				response = textInfoService.updateTextInfo(textInfo);
			}
		}else if(ActivityType.ASSIGNMENT.equals(type)){
			Assignment assignment = activityParam.getAssignment();
			if (assignment != null) {
				activity.setTitle(assignment.getTitle());
				response = assignmentService.updateAssignment(assignment, activityParam.isUpdateFile());
			}
		}else if(ActivityType.SURVEY.equals(type)){
			Survey survey = activityParam.getSurvey();
			if(survey!=null){
				activity.setTitle(survey.getTitle());
				response = surveyService.updateSurvey(survey);
			}
		}else if(ActivityType.TEST.equals(type)){
			Test test = activityParam.getTest();
			activity.setTitle(test.getTitle());
			response = testService.updateTest(test);
		}
		if (response.isSuccess()) {
			response = activityService.updateActivity(activity);
		}
		return response;
	}

	@Override
	public void doDiscussionActivity(DiscussionPost discussionPost) {
		discussionPost = discussionPostService.get(discussionPost.getId());
		DiscussionUser discussionUser = discussionUserService.get(discussionPost.getDiscussionUser().getId());
		DiscussionRelation discussionRelation = discussionRelationService.get(discussionUser.getDiscussionRelation().getId());
		String relationId = discussionRelation.getRelation().getId();
		String discussionId = discussionRelation.getDiscussion().getId();
		Activity activity = activityService.getActivityByEntityId(discussionId);
		if (activity != null) {
			ActivityResult activityResult = activityResultService.createIfNotExists(activity.getId(), relationId);
			Map<String, ActivityAttribute> attributeMap = activity.getAttributeMap();
			Map<String, Object> param = Maps.newHashMap();
			param.put("discussionUserId", discussionPost.getDiscussionUser().getId());
			param.put("creator", ThreadContext.getUser().getId());
			param.put("mainOrSub", "main");
			int myMainPostNum = discussionPostService.getCount(param);
			param.put("mainOrSub", "sub");
			int mySubPostNum = discussionPostService.getCount(param);
			
			int mainPostNum = 0;
			int subPostNum = 0;
			float pct = 0;
			if (attributeMap.containsKey(ActivityAttributeName.DISCUSSION_MAIN_POST_NUM)) {
				String num = attributeMap.get(ActivityAttributeName.DISCUSSION_MAIN_POST_NUM).getAttrValue();
				if (StringUtils.isNotEmpty(num)) {
					mainPostNum = Integer.parseInt(num);
				}
			}
			if (attributeMap.containsKey(ActivityAttributeName.DISCUSSION_SUB_POST_NUM)) {
				String num = attributeMap.get(ActivityAttributeName.DISCUSSION_SUB_POST_NUM).getAttrValue();
				if (StringUtils.isNotEmpty(num)) {
					subPostNum = Integer.parseInt(num);
				}
			}
			if (myMainPostNum == 0 && mySubPostNum == 0){
				activityResult.setState(ActivityResultState.NOT_ATTEMPT);
			}else if(myMainPostNum < mainPostNum || mySubPostNum < subPostNum) {
				activityResult.setState(ActivityResultState.IN_PROGRESS);
			}else{
				activityResult.setState(ActivityResultState.COMPLETE);
				pct = 100;
			}
			
			Map<String, Object> result = Maps.newHashMap();
			result.put(ActivityAttributeName.DISCUSSION_MAIN_POST_NUM, myMainPostNum);
			result.put(ActivityAttributeName.DISCUSSION_SUB_POST_NUM, mySubPostNum);
			result.put(ActivityAttributeName.COMPLETE_PCT, pct);
			activityResult.setDetail(new JsonMapper().toJson(result));
			activityResult.setScore(BigDecimal.valueOf(pct));
			Response response = activityResultService.updateActivityResult(activityResult);
			if (response.isSuccess()) {
				Course course = courseService.getCourse(CSAIdObject.getCSAIdObject().getCid());
				if (!course.getType().equals(CourseType.LEAD) && StringUtils.isNotEmpty(course.getResultSettings())) {
					courseResultBizService.updateCourseResult(course.getId(), Lists.newArrayList(ThreadContext.getUser().getId()));
				}
			}
		}
	}

	@Override
	public Response createExtendActivity(Activity activity, String sectionId, String courseId, String origCourseId) {
		ActivityParam activityParam = new ActivityParam();
		String origActivityId = activity.getId();
		activity.setId(null);
		activity.setRelation(new Relation(sectionId));
		activityParam.setActivity(activity);
		String testId = null;
		Test test = null;
		
		String type = activity.getType();
		if (ActivityType.DISCUSSION.equals(type)) {
			String discussionId = activity.getEntityId();
			Discussion discussion = discussionService.get(discussionId);
			if (discussion != null) {
				discussion.setId(Identities.uuid2());
				DiscussionRelation discussionRelation = new DiscussionRelation();
				discussionRelation.setRelation(new Relation(courseId));
				discussion.setDiscussionRelations(Lists.newArrayList(discussionRelation));
				List<FileInfo> fileInfos = fileService.listFileInfoByRelationId(discussionId);
				if (Collections3.isNotEmpty(fileInfos)) {
					for (FileInfo fileInfo : fileInfos) {
						FileRelation fileRelation = new FileRelation();
						fileRelation.setFileId(fileInfo.getId());
						fileRelation.setRelation(new Relation(discussion.getId()));
						fileRelation.setType("discussion");
						fileRelationService.create(fileRelation);
					}
				}
				activityParam.setDiscussion(discussion);
			}
		}else if(ActivityType.VIDEO.equals(type)){
			String videoId = activity.getEntityId();
			Video video = videoService.getVideo(videoId);
			if (video != null) {
				video.setId(Identities.uuid2());
				VideoRelation videoRelation = new VideoRelation();
				videoRelation.setRelation(new Relation(courseId));
				video.setVideoRelations(Lists.newArrayList(videoRelation));
				List<FileInfo> videoFiles = video.getVideoFiles();
				if (Collections3.isNotEmpty(videoFiles)) {
					for (FileInfo fileInfo : videoFiles) {
						FileRelation fileRelation = new FileRelation();
						fileRelation.setFileId(fileInfo.getId());
						fileRelation.setRelation(new Relation(video.getId()));
						fileRelation.setType("video");
						fileRelationService.create(fileRelation);
					}
				}
				List<FileInfo> fileInfos = video.getFileInfos();
				if (Collections3.isNotEmpty(fileInfos)) {
					for (FileInfo fileInfo : fileInfos) {
						FileRelation fileRelation = new FileRelation();
						fileRelation.setFileId(fileInfo.getId());
						fileRelation.setRelation(new Relation(video.getId()));
						fileRelation.setType("video_file");
						fileRelationService.create(fileRelation);
					}
				}
				video.setVideoFiles(null);
				video.setFileInfos(null);
				activityParam.setVideo(video);
			}
		}else if(ActivityType.HTML.equals(type)){
			String textInfoId = activity.getEntityId();
			TextInfo textInfo = textInfoService.getTextInfo(textInfoId);
			if (textInfo != null) {
				textInfo.setId(Identities.uuid2());
				TextInfoRelation textInfoRelation = new TextInfoRelation();
				textInfoRelation.setRelation(new Relation(courseId));
				textInfo.setTextInfoRelations(Lists.newArrayList(textInfoRelation));
				if (TextInfoType.FILE.equals(textInfo.getType())) {
					List<FileInfo> fileInfos = fileService.listFileInfoByRelationId(textInfoId);
					if (Collections3.isNotEmpty(fileInfos)) {
						for (FileInfo fileInfo : fileInfos) {
							FileRelation fileRelation = new FileRelation();
							fileRelation.setFileId(fileInfo.getId());
							fileRelation.setRelation(new Relation(textInfo.getId()));
							fileRelation.setType("textInfo");
							fileRelationService.create(fileRelation);
						}
					}
				} else if (TextInfoType.PHOTO.equals(textInfo.getType())) {
					Map<String, Object> param = Maps.newHashMap();
					param.put("textInfoId", textInfoId);
					List<TextInfoFile> textInfoFiles = textInfoFileService.listTextInfoFile(param, null);
					for (TextInfoFile textInfoFile : textInfoFiles) {
						String oldId = textInfoFile.getId();
						textInfoFile.setId(Identities.uuid2());
						FileRelation fileRelation = new FileRelation();
						fileRelation.setFileId(textInfoFile.getFileInfo().getId());
						fileRelation.setRelation(new Relation(textInfoFile.getId()));
						fileRelation.setType("textInfoFile");
						Response response = fileRelationService.create(fileRelation);
						if (response.isSuccess()) {
							textInfoFile.setTextInfo(textInfo);
							textInfoFileService.copyPhotos(oldId, textInfoFile.getId());
							textInfoFileService.createTextInfoFile(textInfoFile);
						}
					}
				}
				activityParam.setTextInfo(textInfo);
			}
		}else if(ActivityType.ASSIGNMENT.equals(type)){
			String assignmentId = activity.getEntityId();
			Assignment assignment = assignmentService.getAssignment(assignmentId);
			if (assignment != null) {
				assignment.setId(Identities.uuid2());
				AssignmentRelation assignmentRelation = assignmentRelationService.getAssignmentRelation(AssignmentRelation.getId(assignmentId, origCourseId));
				assignmentRelation.setId(null);
				assignmentRelation.setAssignment(assignment);
				assignmentRelation.setRelation(new Relation(courseId));
				assignment.setAssignmentRelations(Lists.newArrayList(assignmentRelation));
				List<FileInfo> fileInfos = assignment.getFileInfos();
				if (Collections3.isNotEmpty(fileInfos)) {
					for (FileInfo fileInfo : fileInfos) {
						FileRelation fileRelation = new FileRelation();
						fileRelation.setFileId(fileInfo.getId());
						fileRelation.setRelation(new Relation(assignment.getId()));
						fileRelation.setType("assignment");
						fileRelationService.create(fileRelation);
					}
				}
				EvaluateRelation evaluateRelation = evaluateRelationService.getEvaluateRelationByRelationId(assignmentId);
				if (evaluateRelation != null && evaluateRelation.getEvaluate() != null) {
					Evaluate evaluate = evaluateService.getEvaluate(evaluateRelation.getEvaluate().getId());
					evaluate.setId(null);
					Response response = evaluateService.createEvaluate(evaluate);
					if (response.isSuccess()) {
						evaluateRelation.setId(null);
						evaluateRelation.setEvaluate(evaluate);
						evaluateRelation.setRelation(new Relation(assignment.getId()));
						response = evaluateRelationService.createEvaluateRelation(evaluateRelation);
						if (response.isSuccess()) {
							List<EvaluateItem> evaluateItems = evaluate.getEvaluateItems();
							if (Collections3.isNotEmpty(evaluateItems)) {
								for (EvaluateItem evaluateItem : evaluateItems) {
									evaluateItem.setId(null);
									evaluateItem.setEvaluate(evaluate);
									evaluateItemService.createEvaluateItem(evaluateItem);
								}
							}
						}
					}
				}
				activityParam.setAssignment(assignment);
			}
		}else if(ActivityType.SURVEY.equals(type)){
			String surveyId = activity.getEntityId();
			Survey survey = surveyService.findSurveyById(surveyId);
			if (survey != null) {
				survey.setId(Identities.uuid2());
				SurveyRelation surveyRelation = new SurveyRelation();
				surveyRelation.setRelation(new Relation(courseId));
				survey.setSurveyRelations(Lists.newArrayList(surveyRelation));
				List<SurveyQuestion> surveyQuestions = survey.getQuestions();
				if (Collections3.isNotEmpty(surveyQuestions)) {
					for (SurveyQuestion surveyQuestion : surveyQuestions) {
						surveyQuestion.setId(null);
					}
					surveyQuestionService.createSurveyQuestions(survey);
				}
				activityParam.setSurvey(survey);
			}
		}else if(ActivityType.TEST.equals(type)){
			testId = activity.getEntityId();
			test = testService.findTestById(testId);
			if (test != null) {
				test.setId(Identities.uuid2());
				test.setTestPackage(null);
				TestDelivery testDelivery = new TestDelivery();
				testDelivery.setRelationId(courseId);
				test.setTestDeliveries(Lists.newArrayList(testDelivery));
				activityParam.setTest(test);
			}
		}
		Response response = this.createActivity(activityParam);
		if (response.isSuccess()) {
			List<Tag> tags = tagService.findTagByNameAndRelations(null, Lists.newArrayList(origActivityId), null);
			if (Collections3.isNotEmpty(tags)) {
				for (Tag tag : tags) {
					TagRelation tagRelation = new TagRelation();
					tagRelation.setTag(tag);
					tagRelation.setRelation(new Relation(activity.getId(), "activity"));
					tagRelationService.createTagRelation(tagRelation);
				}
			}
			if (ActivityType.TEST.equals(type)) {
				List<Question> questions = testService.findQuestionsByTestId(testId);
				if(Collections3.isNotEmpty(questions)){
					int index = 0;
					for (Question question : questions) {
						question.setId(null);
						testService.addTestQuestion(test, question, new QuestionFormKey("P1:S1:Q"+index));
						index++;
					}
				}
			}
		}
		return response;
	}
}
