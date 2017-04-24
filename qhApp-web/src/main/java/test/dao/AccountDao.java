package test.dao;

import org.springframework.stereotype.Repository;
import test.entity.Account;

/**
 * Created by noname on 2017/4/23.
 */
@Repository("AccountDao")
public interface AccountDao {
    public Account getAccountInfo(String uuid);

    public boolean resetPwd(String uuid);
}
