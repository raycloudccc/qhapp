package com.noname.qh.service.impl;

import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;
import com.noname.qh.dao.AccountDao;
import com.noname.qh.service.AccountService;
import com.noname.qh.utils.DataGridUtils;

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
