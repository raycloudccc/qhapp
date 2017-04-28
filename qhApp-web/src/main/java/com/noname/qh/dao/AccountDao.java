package com.noname.qh.dao;

import org.springframework.stereotype.Repository;
import com.noname.qh.entity.Account;

/**
 * Created by noname on 2017/4/23.
 */
@Repository("AccountDao")
public interface AccountDao {
    public Account getAccountInfo(String uuid);

    public boolean resetPwd(String uuid);
}
