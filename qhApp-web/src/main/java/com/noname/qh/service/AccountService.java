package com.noname.qh.service;

import net.sf.json.JSONObject;

/**
 * Created by noname on 2017/4/23.
 */
public interface AccountService {
    public JSONObject getAccountInfo(String uuid);
}
