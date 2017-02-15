package com.haoyu.ncts.note.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.note.service.INoteBizService;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.note.entity.Note;
import com.haoyu.sip.note.service.INoteService;

@Controller
@RequestMapping("**/note")
public class NoteBizController extends AbstractBaseController {
	
	@Resource
	private INoteBizService noteBizService;
	@Resource
	private INoteService noteService;
	
	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/study/note/");
	}
	
	@RequestMapping(value="loadMoreNote",method = RequestMethod.GET)
	@ResponseBody
	public List<Note> loadMoreNote(Note note,Model model){
		return noteBizService.listMoreNote(note, getPageBounds(10, true));
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String list(Note note ,Model model){
		model.addAttribute("note" ,note);
		getPageBounds(10, true);
		return getLogicalViewNamePrefix() + "list_note";
	}
	
	@RequestMapping(value = "create", method=RequestMethod.GET)
	public String create(Note note,Model model){
		model.addAttribute("note",note);
		return getLogicalViewNamePrefix() + "edit_note"; 
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Note note,Model model){	
		model.addAttribute("note",noteService.findNoteById(note.getId()));
		return getLogicalViewNamePrefix() + "edit_note";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response create(Note note){
		return this.noteService.createNote(note);
	}
	
	@RequestMapping(value="update",method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Note note){
		return this.noteService.updateNote(note);
	}
	
	@RequestMapping(value="delete",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Note note){		
		return this.noteService.deleteNoteByLogic(note);
	}
	
	@RequestMapping(value="course",method=RequestMethod.GET)
	public String loadCourseNote(String courseId,String sectionId,Model model){
		getPageBounds(10, true);
		model.addAttribute("cid", courseId);
		model.addAttribute("sid", sectionId);
		return this.getLogicalViewNamePrefix() + "note";
	}
}
