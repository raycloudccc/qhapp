package test.service;

import net.sf.json.JSONObject;
import test.entity.Account;

/**
 * Created by noname on 2017/4/23.
 */
public interface AccountService {
    public JSONObject getAccountInfo(String uuid);
}
