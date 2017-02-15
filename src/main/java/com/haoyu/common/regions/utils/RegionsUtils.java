package com.haoyu.common.regions.utils;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.JacksonJsonRedisSerializer;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.common.regions.dao.IRegionsDao;
import com.haoyu.common.regions.entity.Regions;
import com.haoyu.sip.core.mapper.JsonMapper;
import com.haoyu.sip.core.utils.PropertiesLoader;

@Component
public class RegionsUtils {
	
	@Resource
	private IRegionsDao regionsDao;
	@Resource  
	private RedisTemplate redisTemplate;
	@Resource
	private PropertiesLoader propertiesLoader;
	
	private static String appName;
	
	private static RegionsUtils regionsUtils;
	
	@PostConstruct  
	public void init() {  
		regionsUtils = this;  
		regionsUtils.regionsDao = this.regionsDao;  
		regionsUtils.redisTemplate = this.redisTemplate;  
		appName = propertiesLoader.getProperty("redis.app.key");
	}  
	
	public static void initAll(){
		Set<String> keys =  regionsUtils.redisTemplate.keys(appName+":regions:*");
		if(!keys.isEmpty()){
			regionsUtils.redisTemplate.delete(keys);
		}
	}
	
	public static Map<String, Regions> getEntryMap(String level) {
		Map<String, Regions> entryMap = Maps.newHashMap();
		regionsUtils.redisTemplate.setHashValueSerializer(new JacksonJsonRedisSerializer(Regions.class));
		HashOperations<String,String,Regions> hashOper = regionsUtils.redisTemplate.opsForHash();
		String key = appName+":regions:"+level;
		if(regionsUtils.redisTemplate.hasKey(key)){
			entryMap = hashOper.entries(key);
		}else {
			Regions regions = new Regions();
			regions.setRegionsLevel(level);
			entryMap = regionsUtils.regionsDao.selectForMap(regions);
			if (entryMap != null && !entryMap.isEmpty()) {
				hashOper.putAll(key, entryMap);
			}
		}
		return entryMap;
	}
	
	public static Map<String, Regions> getEntryMap(String level, String parentCode) {
		Map<String, Regions> entryMap = getEntryMap(level);
		Map<String, Regions> resultMap = Maps.newHashMap();
		for (Regions regions : entryMap.values()) {
			if (parentCode.equals(regions.getParentCode())) {
				resultMap.put(regions.getRegionsCode(), regions);
			}
		}
		return resultMap;
	}
	
	public static List<Regions> getEntryList(String level) {
		Map<String, Regions> entryMap = getEntryMap(level);
		return getSortEntryList(entryMap);
	}
	
	public static String getEntryListJson(String level) {
		Map<String, Regions> entryMap = getEntryMap(level);
		List<Regions> dictEntries = getSortEntryList(entryMap);
		String a = new JsonMapper().toJson(dictEntries);
		return a;
	}
	
	public static List<Regions> getEntryList(String level, String parentCode) {
		Map<String, Regions> entryMap = getEntryMap(level,parentCode);
		return getSortEntryList(entryMap);
	}

	private static List<Regions> getSortEntryList(Map<String, Regions> entryMap) {
		List<Regions> entryList = Lists.newArrayList();
		for (Regions regions : entryMap.values()) {
			entryList.add(regions);
		}
		return entryList;
	}
	
	public static String getEntryOptions(String level){
		List<Regions> entryList = getEntryList(level);
		return getOptionsString(entryList);
	}
	
	public static String getEntryOptions(String level,String parentCode){
		List<Regions> entryList = getEntryList(level, parentCode);
		return getOptionsString(entryList);
	}
    /** 
     * 把List<Regions>变成页面上的选择下选框的内容
     */
	private static String getOptionsString(List<Regions> entryList) {
		StringBuffer entryOptions = new StringBuffer();
		for(Regions entry: entryList){
			entryOptions.append("<option value='").append(entry.getRegionsCode()).append("'>");
			entryOptions.append(entry.getRegionsName()).append("</option>");
		}
		return entryOptions.toString();
	}
	
	public static String getEntryOptionsSelected(String level,String defaultCode){
		List<Regions> entryList = getEntryList(level);
		return getOptionsSelectedString(defaultCode, entryList);
	}
	
	/**
	 * 截取 getEntryOptionsSelected 取多少个的意思
	 */
	public static String getEntryOptionsSelected(String level,String defaultValue,int toIndex){
		List<Regions> entryList = getEntryList(level);
		entryList=entryList.subList(0, toIndex);
		return getOptionsSelectedString(defaultValue, entryList);
	}
	
	public static String getEntryOptionsSelected(String level,String parentCode,String defaultValue){
		List<Regions> entryList = getEntryList(level, parentCode);
		return getOptionsSelectedString(defaultValue, entryList);
	}
     
	/** 
     * 把List<Regions>变成页面上的选择下选框的内容，有默认值
     */
	private static String getOptionsSelectedString(String defaultValue, List<Regions> entryList) {
		StringBuffer entryOptions = new StringBuffer();
		for(Regions entry: entryList){
			entryOptions.append("<option value='").append(entry.getRegionsCode()).append("'");
			if (StringUtils.isNotEmpty(defaultValue) && defaultValue.equals(entry.getRegionsCode())) {
				entryOptions.append("selected='selected' ");
			}
			entryOptions.append(">").append(entry.getRegionsName()).append("</option>");
		}
		return entryOptions.toString();
	}
	
	public static String getEntryName(String level,String regionsCode){
		Map<String, Regions> entryMap = getEntryMap(level);
		if (entryMap != null && entryMap.containsKey(regionsCode)) {
			return entryMap.get(regionsCode).getRegionsName();
		}
		return "";
	}
	
	public static String getEntryValue(String level,String regionsName){
		Map<String, Regions> entryMap = getEntryMap(level);
		if (entryMap != null) {
			for (Regions dictEntry : entryMap.values()) {
				if (dictEntry.getRegionsName().equals(regionsName)) {
					return dictEntry.getRegionsCode();
				}
			}
		}
		return "";
	}

	public static Regions getEntry(String level, String regionsCode){
		Map<String, Regions> entryMap = getEntryMap(level);
		if (entryMap != null && entryMap.containsKey(regionsCode)) {
			return entryMap.get(regionsCode);
		}
		return null;
	}

}
