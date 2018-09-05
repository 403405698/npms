package com.yy.young.pms.util;

import com.yy.young.common.util.CommonUtil;

/**
 * @description
 * @authhor yangwei
 * @create 2018/4/2 0002
 */
public class UUID {
    public static void main(String[] args) {
        for (int i = 0; i < 10 ; i++) {
            System.out.println(CommonUtil.getUUID());
        }
    }
}
