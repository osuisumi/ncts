package com.haoyu.ncts.note.service;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.note.entity.Note;

public interface INoteBizService {
	List<Note> listMoreNote(Note note, PageBounds pageBounds);
}
