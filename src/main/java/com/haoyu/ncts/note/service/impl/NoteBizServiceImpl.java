package com.haoyu.ncts.note.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.note.dao.INoteBizDao;
import com.haoyu.ncts.note.service.INoteBizService;
import com.haoyu.ncts.note.util.NoteRelationType;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.note.entity.Note;
import com.haoyu.sip.utils.Collections3;
@Service
public class NoteBizServiceImpl implements INoteBizService{
	
	@Resource
	private INoteBizDao noteBizDao;
	
	@Resource
	private ISectionService sectionServiceImpl;
	
	@Override
	public List<Note> listMoreNote(Note note, PageBounds pageBounds) {
		Map<String, Object> parameter = new HashMap<String, Object>();
		List<String> relationIds = Lists.newArrayList();
		Relation relation = note.getRelation();
		if (NoteRelationType.COURSE.equals(relation.getType())) {
			relationIds = Collections3.extractToList(sectionServiceImpl.listSectionByCourseId(relation.getId()), "id");
			parameter.put("relationIds", relationIds);
		}
		if (NoteRelationType.SECTION.equals(relation.getType())) {
			relationIds = Lists.newArrayList(relation.getId());
			parameter.put("relationIds", relationIds);
		}
		if(StringUtils.isNotEmpty(note.getContent())){
			parameter.put("content",note.getContent());
		}
		return noteBizDao.listMoreNote(parameter, pageBounds);
	}

}
