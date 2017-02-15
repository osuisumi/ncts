package com.haoyu.ncts.course.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.dao.ICourseRelationDao;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseRelation;
import com.haoyu.ncts.course.service.ICourseBizService;
import com.haoyu.ncts.course.service.ICourseRelationBizService;
import com.haoyu.ncts.course.service.ICourseRelationService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.utils.Collections3;

@Service
public class CourseRelationBizServiceImpl implements ICourseRelationBizService{
	
	@Resource
	private ICourseRelationService courseRelationService;
	@Resource
	private ICourseRelationDao courseRelationDao;
	@Resource
	private ICourseBizService courseBizService;
	@Resource
	private ICourseService courseService;
	
	@Override
	public Response updateCourseRelations(String courseIds, String relationId,String courseTopicId) {
		Map<String,Object> selectParam = Maps.newHashMap();
		selectParam.put("relationId", relationId);
		List<CourseRelation> allCourseRelation = courseRelationService.listCourseRelations(selectParam, null);
		List<CourseRelation> prepareAdd = generatePrepareAdd(courseIds, relationId);
		List<CourseRelation> prepareDelete = Lists.newArrayList();
		for(CourseRelation existCourseRelation:allCourseRelation){
			if(prepareAdd.contains(existCourseRelation)){
				prepareAdd.remove(existCourseRelation);
			}else{
				prepareDelete.add(existCourseRelation);
			}
		}
		Response response = Response.successInstance();
		if(CollectionUtils.isNotEmpty(prepareAdd)){
			for(CourseRelation add:prepareAdd){
				response = courseBizService.createExtendCourse(add.getCourse().getId(),courseTopicId);
				if (response.isSuccess()) {
					Course branch = (Course) response.getResponseData();
					add.setCourse(branch);
					response = courseRelationService.createCourseRelation(add);
				}
			}
		}
		if(response.isSuccess()){
			if(CollectionUtils.isNotEmpty(prepareDelete)){
				Map<String,Object> param = Maps.newHashMap();
				param.put("ids",Collections3.extractToList(prepareDelete, "id"));
				response = courseRelationDao.deleteCourseRelation(param)>0?Response.successInstance():Response.failInstance();
				if (response.isSuccess()) {
					for (CourseRelation courseRelation : prepareDelete) {
						courseService.deleteCourseByLogic(courseRelation.getCourse());
					}
				}
			}
		}
		return response;

	}
	
	private List<CourseRelation> generatePrepareAdd(String courseIds,String relationId){
		List<CourseRelation> result = Lists.newArrayList();
		if(StringUtils.isNotEmpty(courseIds)){
			List<String> courseIdList = Arrays.asList(courseIds.split(","));
			for(String courseId:courseIdList){
				CourseRelation courseRelation = new CourseRelation();
				courseRelation.setCourse(new Course(courseId));
				courseRelation.setRelation(new Relation(relationId));
				result.add(courseRelation);
			}
		}
	
		return result;
	}

}
