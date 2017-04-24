package test.service.impl;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;
import test.dao.AccountDao;
import test.entity.Account;
import test.service.AccountService;
import test.utils.DataGridUtils;

import javax.annotation.Resource;

/**
 * Created by noname on 2017/4/23.
 */
@Service("AccountService")
public class AccountServiceImpl implements AccountService{

    @Resource(name="AccountDao")
    private AccountDao accountDao;
    @Resource(name="DataGridUtils")
    private DataGridUtils dataGridUtils;

    @Override
    public JSONObject getAccountInfo(String uuid) {
        return dataGridUtils.parseJSON(1,accountDao.getAccountInfo(uuid));

    }
}
