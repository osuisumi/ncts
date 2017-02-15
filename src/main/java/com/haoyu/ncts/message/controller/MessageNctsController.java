package com.haoyu.ncts.message.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.message.entity.Message;
import com.haoyu.sip.message.service.IMessageService;

@RequestMapping("message")
@Controller
public class MessageNctsController extends AbstractBaseController{
	
	@Resource
	private IMessageService messageService;
	
	private String getLogicViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/message/");
	}
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	public String list(Model model){
		model.addAttribute("message", getMessage());
		getPageBounds(3, true);
		return getLogicViewNamePerfix() + "list_message";
	}
	
	@RequestMapping(value="list/more",method=RequestMethod.GET)
	public String listMore(Model model){
		model.addAttribute("message",getMessage());
		getPageBounds(8,true);
		return getLogicViewNamePerfix() + "list_more_message";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(Message message){
		return messageService.createMessage(message);
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String createMessage(User receiver,Model model){
		model.addAttribute("receiver", receiver);
		return getLogicViewNamePerfix() + "edit_message";
	}
	
	@RequestMapping(value="create/reply",method=RequestMethod.GET)
	public String createReply(String messageId,Model model){
		model.addAttribute("messageId", messageId);
		return getLogicViewNamePerfix() + "edit_reply_message";
	}
	
	private Message getMessage(){
		Message message = new Message();
		message.setReceiver(ThreadContext.getUser());
		return message;
	}

}
