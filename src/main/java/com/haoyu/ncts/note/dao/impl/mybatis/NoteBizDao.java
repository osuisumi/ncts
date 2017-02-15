package com.haoyu.ncts.note.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.note.dao.INoteBizDao;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.note.entity.Note;
@Repository
public class NoteBizDao extends MybatisDao implements INoteBizDao {

	@Override
	public List<Note> listMoreNote(Map<String, Object> param, PageBounds pageBounds) {
		param.put("creator", ThreadContext.getUser().getId());
		return super.selectList("select", param, pageBounds);
	}

}
