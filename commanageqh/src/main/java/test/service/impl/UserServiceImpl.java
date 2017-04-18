package test.service.impl;

/**
 * Created by 001117030057 on 2017/4/18.
 */
import test.dao.UserDao;
import test.entity.User;
import test.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by ccc on 2017-04-18
 * 用户service实现类
 */
@Service("UserService")
public class UserServiceImpl implements UserService {

    @Resource(name = "UserDao")
    private UserDao userDao;

    public User findByUsernameAndPwd(String name, String pwd) {

        return userDao.findByUsernameAndPwd(name, pwd);
    }

    public List<User> find(User user){

        return userDao.find(user);
    }


    public void add(User user) {

        userDao.add(user);
    }

    public void update(User user) {

        userDao.update(user);
    }

    public void delete(String id) {

        userDao.delete(id);
    }
}
