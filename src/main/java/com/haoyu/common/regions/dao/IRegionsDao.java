package com.haoyu.common.regions.dao;

import java.util.Map;

import com.haoyu.common.regions.entity.Regions;

public interface IRegionsDao {

	Map<String, Regions> selectForMap(Regions regions);

}
