package com.fleamarket.common;

public class ThnSize<T> {
	
	private T width;
	private T height;
	
	public ThnSize(T width, T height) {
		this.width = width;
		this.height = height;
	}
	
	public T getWidth() {
		return width;
	}
	
	public T getHeight() {
		return height;
	}
	
}
