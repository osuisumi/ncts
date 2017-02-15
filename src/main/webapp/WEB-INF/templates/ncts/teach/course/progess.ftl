<#include "/ncts/teach/include/layout.ftl"/>
<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<@layout>
	<@activitiesDirective userId=userId!'' relationIds=sectionIds getResult=true>
		<#list activities as activity>
			<input class="activityHidden" type="hidden" id="${activity.id }" score="${(activityResultMap[activity.id].score)!0 }" title="${activity.title! }">
		</#list>
		<div class="g-cl-content g-work-read">
	        <div class="g-cl-boxP g-cl-resource">
	            <div class="g-studyAct-box1">
	            	<div class="m-studyTask-tBtn">
	            		<a href="${ctx}/${cid!}/teach/course/statistic" class="btn u-inverse-btn u-opt-btn">返回列表</a>
					</div>
					<div id="main" style="width: 100%; height: 550px;"></div>
				</div>
			</div>
		</div>
		<script type="text/javascript"> 
		 	$(function(){
		 		lightMenu('statistic');
		 		
		 		var titles = new Array();
		 		var scores = new Array();
		 		$('.activityHidden').each(function(){
		 			title = $(this).attr('title');
		 			titles.push(title);
		 			score = $(this).attr('score');
		 			scores.push(score);
		 		});
		 		
		 		var myChart = echarts.init(document.getElementById('main'));
		 		var option = {
		 	            title: {
		 	                text: '学习进度'
		 	            },
		 	            tooltip: {},
		 	            legend: {
		 	                data:['活动完成进度']
		 	            },
		 	            xAxis: {
		 	                data: titles,
		 	                axisLabel: {
		 	                	interval: 0,
		 	                	textStyle: {
		 	                		fontSize: 12,
		 	                		color: '#1e8be9'
		 	                	},
		 	                	formatter:function(val){
		 	                		if(getByteLength(val) > 15){
		 	                			return val.substring(0, 5) + '..';
		 	                		}
		 	                	    return val;
		 	                	}
		 	                }
		 	            },
		 	            yAxis: {
		 	            	name: '活动完成进度(%)',
		 	            	min: 0,
		 	            	max: 100,
		 	            	interval: 20
		 	            },
		 	            series: [{
		 	                name: '活动完成进度(%)',
		 	                type: 'bar',
		 	                data: scores,
		 	                label: {
		 	                	normal: {
		 	                    	show: true,
		 	                    	position: 'outside'
		 	                  	}
		 	              	}
		 	            }]
		 	        };
		 		myChart.setOption(option);
		 	});
		</script>
	</@activitiesDirective>
</@layout>