package test.service;

/**
 * Created by 001117030057 on 2017/4/18.
 */
import test.entity.User;

import java.util.List;

/**
 * Created by ccc on 2017-03-30
 * 用户service接口
 */
public interface UserService {

    /**
     *  Created by ccc on 2017-03-22
     *  根据用户名和密码查询用户
     * @param username
     * @param password
     * @return
     */
    public User findByUsernameAndPwd(String username, String password);

    /**
     *  Created by ccc on 2017-03-30
     *  获取用户
     * @return
     */
    public List<User> find(User User);

    /**
     *  Created by ccc on 2017-03-30
     *  新增
     * @param User
     */
    public void add(User User);

    /**
     *  Created by ccc on 2017-03-30
     *  修改
     * @param User
     */
    public void update(User User);

    /**
     *  Created by ccc on 2017-03-30
     *  删除
     * @param id
     */
    public void delete(String id);
}
