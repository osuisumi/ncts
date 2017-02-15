package com.haoyu.common.regions.dao.impl.mybatis;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.haoyu.common.regions.dao.IRegionsDao;
import com.haoyu.common.regions.entity.Regions;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class RegionsDao extends MybatisDao implements IRegionsDao{

	@Override
	public Map<String, Regions> selectForMap(Regions regions) {
		return this.selectMap("selectForMap", regions, "regionsCode");
	}

}
