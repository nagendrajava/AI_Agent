package com.ics.ds;

import java.util.Comparator;

public class GenricComparator<T> implements Comparator<T> {
    private final Comparator<T> comparator;

    public GenricComparator(Comparator<T> comparator){
        this.comparator=comparator;
    }
    @Override
    public int compare(T a, T b){
        return comparator.compare(a,b);
    }
}
