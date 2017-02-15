package com.haoyu.ncts.note.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.note.entity.Note;

public interface INoteBizDao {
	List<Note> listMoreNote(Map<String, Object> param, PageBounds pageBounds);
}
