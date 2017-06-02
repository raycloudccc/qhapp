package com.noname.qh.utils;

import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


/**
 * Created by noname on 2017/5/22.
 */
//@EnableScheduling
//@Component("scheduledDemo")
//@Lazy(false)
public class ScheduledDemo {
//    @Scheduled(fixedDelay = 2000)
    public static void print(){
        System.out.println(System.currentTimeMillis());
    }


}
