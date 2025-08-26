package com.ics.ds;

import java.util.*;

public class LRUCache {
    private final int capacity;
    private final Map<Integer,Integer> map;
    private final LinkedHashSet<Integer> order;
    public LRUCache(int capacity){
        this.capacity = capacity;
        this.map = new HashMap<>();
        this.order = new LinkedHashSet<>();
    }
    public int get(int key){
        if (!map.containsKey(key) )return -1;
        order.remove(key);
        order.add(key);
        return map.get(key);
    }
    public void put(int key, int value){
        if(map.containsKey(key)){
            order.remove(key);
        }
        else if(map.size()==capacity){
            int oldest =order.iterator().next();
            order.remove(oldest);
            map.remove(oldest);
        }
        map.put(key,value);
        order.add(key);
    }
}
