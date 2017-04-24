package test.service.impl;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;
import test.dao.AccountDao;
import test.entity.Account;
import test.service.AccountService;

import javax.annotation.Resource;

/**
 * Created by noname on 2017/4/23.
 */
@Service("AccountService")
public class AccountServiceImpl implements AccountService{

    @Resource(name="AccountDao")
    private AccountDao accountDao;

    @Override
    public JSONObject getAccountInfo(String uuid) {
        JSONObject obj=new JSONObject();
        JSONArray arr=new JSONArray();
        obj.put("total",1);
        JSONArray a=arr.fromObject(accountDao.getAccountInfo(uuid));
        obj.put("rows",a);
        System.out.println("obj:"+obj);
        return obj;
    }
}
