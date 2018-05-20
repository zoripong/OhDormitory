package kr.hs.emirim.uuuuri.ohdormitory.Model;

import java.io.Serializable;

/**
 * Created by 유리 on 2017-10-01.
 */

public class User implements Serializable {
    private String emirim_id;
    private String password;
    private String name;
    private int room_num;
    private String parent_phone;

    public User(String emirim_id, String password, String name, int room_num, String parent_phone) {
        this.emirim_id = emirim_id;
        this.password = password;
        this.name = name;
        this.room_num = room_num;
        this.parent_phone = parent_phone;
    }


    public String getEmirim_id() {
        return emirim_id;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public int getRoom_num() {
        return room_num;
    }

    public String getParent_phone() {
        return parent_phone;
    }

    @Override
    public String toString() {
        return "User{" +
                "emirim_id='" + emirim_id + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", room_num=" + room_num +
                ", parent_phone='" + parent_phone + '\'' +
                '}';
    }
}
