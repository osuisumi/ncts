<style>
.error{color:red;}
</style>
<form id="saveCourseForm" action="${ctx }/make/course" method="post">
	<#if (course.id)! != ''>
		<script>
			$('#saveCourseForm').attr('method','put').attr('action', '${ctx }/make/course/${(course.id)!}');
		</script>
		<#else>
		<input type="hidden" name="isTemplate" value="Y">
		<input type="hidden" name="state" value="editing">
		<input type="hidden" name="courseAuthorizes[0].user.id" value="${Session.loginer.id }">
		<input type="hidden" name="courseAuthorizes[0].role" value="maker">
	</#if>
	<div class="g-addElement-lyBox">
        <div class="g-addElement-lst g-addCourse-lst">
            <li class="m-addElement-item">
                <strong class="ltxt"><em>*</em>课程名称：</strong>
                <div class="center">
                    <div class="m-pbMod-ipt">
                        <input type="text" name="title" value="${(course.title)!}" placeholder="如：议论文写作技巧" class="u-pbIpt required">
                    </div>
                </div>
            </li>
            <li class="m-addElement-item">
                <strong class="ltxt"><em>*</em>课程类型：</strong>
                <div class="center">
                    <div class="m-selectbox">
                    	<strong><span class="simulateSelect-text">引领式</span><i class="trg"></i></strong>
                        <i class="trg"></i>
                        <select id="selectCourseType" name="type" onchange="changeCourseType(this)">
                            <option value="lead" selected="selected">引领式</option>
                            <option value="mic">微课</option> 
                            <option value="self">自主式</option>
                        </select>
                    </div>
                    <script>
						$(function(){
							$('#selectCourseType').simulateSelectBox({
								byValue: "${(course.type)!}"
						    });	
						});
					</script>
                    <p class="m-addElement-ex" id="CourseTypeExplain">引领式课程中将有课程作者、助教等参与课程学习的引导，疑难解答等。<!-- </br>自主式课程则完全由学员自主完成学习.</br>微课程则由一个10-15分钟的视频为主，讲授一个知识点，一般还可搭配一个测验。 --></p>
                </div>
            </li>
            <li class="m-addElement-item">
                <strong class="ltxt"><em>*</em>课程机构：</strong>
                <div class="center">
                    <div class="m-pbMod-ipt">
                        <input type="text" name="organization" value="${(course.organization)!}" placeholder="如：肇庆学院或广东第二师范学院网络教育学院" class="u-pbIpt required">
                    </div>
                </div>
            </li>
            <li class="m-addElement-item">
                <strong class="ltxt">计划开课学期：</strong>
                <div class="center">
                    <div class="m-slt-row">
                        <div class="block">
                            <div class="m-selectbox">
                                <strong><span class="simulateSelect-text">-&nbsp;&nbsp;请选择年份&nbsp;&nbsp;-</span><i class="trg"></i></strong>
                                <i class="trg"></i>
                                <select id="yearSelect" name="year">
                                	<option value="" selected="selected">-&nbsp;&nbsp;请选择年份&nbsp;&nbsp;- </option>
                                </select>
								<script>
									$(function(){
										var d = new Date();
										var year = d.getFullYear();
										for(var i = year; i < year + 2; i++){
											$('#yearSelect').append('<option value="'+i+'">'+i+'</option>');
										}
										$('#yearSelect').find('option[value="${(course.year)!}"]').prop('selected',true);
									});
								</script>
                            </div>
                        </div>
                        <div class="space"></div>
                        <div class="block">
                            <div class="m-selectbox">
                                <strong><span class="simulateSelect-text">-&nbsp;&nbsp;请选择期次&nbsp;&nbsp;-</span><i class="trg"></i></strong>
                                <select id="termSelect" name="term">
                                    <option value="" selected="selected">-&nbsp;&nbsp;请选择期次&nbsp;&nbsp;-</option>
                                </select>
								<script>
									$(function(){
										var max = "${DictionaryUtils.getEntryValue('COURSE_EXTEND_ATTRIBUTE', '最大期次')}";
										for(var i=1; i<=parseInt(max); i++){
											$('#termSelect').append('<option value="T'+i+'">T'+i+'</option>');
										}
										$('#termSelect').find('option[value="${(course.term)!}"]').prop('selected',true);
									});
								</script>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            <!-- <li id="courseTimeLi" class="m-addElement-item">
                <strong class="ltxt"><em>*</em>课程开放时间：</strong>
                <div class="center">
                	<div class="m-slt-row">
                        <div class="block" style="width: 46%;">
                            <div class="m-pbMod-ipt date">
                                <input name="startTime" type="text" value="${(course.timePeriod.startTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({minDate:'${.now?date}',dateFmt:'yyyy-MM-dd'})" class="u-pbIpt">
                            </div>
                        </div>
                        <div class="space" style="width: 8%;">至</div>
                        <div class="block" style="width: 46%;">
                            <div class="m-pbMod-ipt date">
                                <input name="endTime" type="text" value="${(course.timePeriod.startTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({minDate:'${.now?date}',dateFmt:'yyyy-MM-dd'})" class="u-pbIpt">
                            </div>
                        </div>
                    </div>
                </div>
            </li> -->
            <li class="m-addElement-item">
                <strong class="ltxt">学时：</strong>
                <div class="center">
                    <div class="m-pbMod-ipt">
                        <input type="text" name="studyHours" value="${(course.studyHours)!}" placeholder="请输入学时" class="u-pbIpt number">
                    </div>
                </div>
            </li> 
            <li class="m-addElement-btn">
            	<a onclick="saveCourse()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmAddCourse">创建</a>
                <a onclick="cancle()" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
            </li>
        </div>
    </div>
</form>
<script>
	$(function(){
		//选择课程类型
    	selectCourseType();
		//下拉框
    	$(".m-selectbox select").simulateSelectBox();
	});

	function saveCourse(){
		if (!$('#saveCourseForm').validate().form()) {
			return false;
		}
		var data = $.ajaxSubmit('saveCourseForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('提交成功', function(){
				var id = json.responseData.id;
				parent.window.location.href = '${ctx}/make/course/'+id+'/editCourseContent';
			});
		}else{
			alert('系统繁忙,请稍候再试!');
		}
	}
	
	function cancle(){
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭   
	}
	
	//选择课程类型
	function selectCourseType(){
	    var courseTypeIndex = 0;
	    var courseTypeExArr = [
	        {explain:'引领式课程中将有课程作者、助教等参与课程学习的引导，疑难解答等。'},
	        {explain:'自主式课程则完全由学员自主完成学习。'},
	        {explain:'微课程则由一个10-15分钟的视频为主，讲授一个知识点，一般还可搭配一个测验。'}
	    ];
	    judgeCourseType($('#selectCourseType'));
	    changeCourseData();
	    $("#selectCourseType").on('change',function(){
	        var $this = $(this);
	        judgeCourseType($this);
	        changeCourseData();
	    });
	
	    function changeCourseData(){
	        $('#CourseTypeExplain').text(courseTypeExArr[courseTypeIndex].explain);
	        $('#confirmAddCourse').attr('data-href',courseTypeExArr[courseTypeIndex].urls);
	    }
	    
	    function judgeCourseType(selectBox){
	        var $this = selectBox;
	        if($this.val() == 'lead'){
	            courseTypeIndex = 0;
	        }else if($this.val() == 'self'){
	            courseTypeIndex = 1;
	        }else if($this.val() == 'mic'){
	            courseTypeIndex = 2;
	        }
	    }
	}
	
	function changeCourseType(obj){
		var value = $(obj).val();
		if(value == 'lead'){
			$('#courseTimeLi').show();
		}else{
			$('#courseTimeLi').hide();
		}
	}
</script>