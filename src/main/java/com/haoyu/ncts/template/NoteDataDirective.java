package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.Section;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.note.util.NoteRelationType;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.note.entity.Note;
import com.haoyu.sip.note.service.INoteService;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

public class NoteDataDirective implements TemplateDirectiveModel{
	
	@Resource
	private INoteService noteService;
	
	@Resource
	private ISectionService sectionService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		PageBounds pageBounds = null;
		Map<String, Object> param = Maps.newHashMap();
		List<String> relationIds = Lists.newArrayList();
		List<Section> sections = Lists.newArrayList();
		Map<String, Integer> sectionCounts = Maps.newHashMap();
		Map<String, String> sectionTitles = Maps.newHashMap();
		String courseId = null;
		if(params.containsKey("courseId")){
			courseId = params.get("courseId").toString();
			sections = sectionService.listSectionByCourseId(courseId);
			if (Collections3.isNotEmpty(sections)) {
				sectionTitles = Collections3.extractToMap(sections, "id", "title");
				relationIds = Collections3.extractToList(sections, "id");
			}
			env.setVariable("sectionTitles", new DefaultObjectWrapper().wrap(sectionTitles));
		}
		if (params.containsKey("note") && params.get("note") != null) {
			BeanModel beanModel = (BeanModel) params.get("note");
			if (beanModel != null) {
				Note note = (Note) beanModel.getWrappedObject();
				if(!note.getContent().isEmpty()){
					param.put("content", note.getContent());
				}
				if(NoteRelationType.COURSE.equals(note.getRelation().getType())){
					sections = sectionService.listSectionByCourseId(note.getRelation().getId());
					if(Collections3.isNotEmpty(sections)){
						relationIds = Collections3.extractToList(sections, "id");
						param.put("relationIds",relationIds);
					}else{
						param.put("relationIds", Lists.newArrayList(courseId));
					}
				}
				if(NoteRelationType.SECTION.equals(note.getRelation().getType())){
					relationIds = Lists.newArrayList(note.getRelation().getId());
					param.put("relationIds",relationIds);
				}					
				param.put("isDeleted", "N");
				if(note.getCreator() != null && note.getCreator().getId() != null){
					param.put("creator", note.getCreator().getId());
				}else {
					param.put("creator", ThreadContext.getUser().getId());				
				}
			}
		}
		if (params.containsKey("pageBounds")  && params.get("pageBounds") != null) {
			BeanModel beanModel = (BeanModel) params.get("pageBounds");
			pageBounds = (PageBounds)beanModel.getWrappedObject();
		}
		List<Note> notes = noteService.listNote(param, pageBounds);
		env.setVariable("notes", new DefaultObjectWrapper().wrap(notes));
		if (Collections3.isNotEmpty(relationIds)) {
			sectionCounts = noteService.getNoteCountByRelationIds(relationIds);
		}
		env.setVariable("sectionCounts", new DefaultObjectWrapper().wrap(sectionCounts));
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)notes;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
	}
}
