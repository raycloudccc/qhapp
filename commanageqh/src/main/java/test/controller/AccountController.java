package test.controller;

import net.sf.json.JSONObject;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import test.entity.Account;
import test.service.impl.AccountServiceImpl;

import javax.annotation.Resource;

/**
 * Created by noname on 2017/4/23.
 */

@Controller
@RequestMapping("/account")
public class AccountController {

    @Resource(name="AccountService")
    private AccountServiceImpl accountService;

    @RequestMapping("toshowaccountinfo")
    public String toshowaccountinfo(){
        return "showaccountinfo";
    }

    @RequestMapping("getAccountInfo")
    @ResponseBody
    public JSONObject getAccountInfo(@Param("uuid") String uuid){
        return accountService.getAccountInfo(uuid);
    }

}
