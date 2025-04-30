package com.fleamarket.etc;

public class ThumbnailMakerFactory {
	
	//썸네일이미지가 필요한 페이지에 알맞은 크기의 썸네일 이미지들이 여러개 필요함
	//후기 페이지: 리스트에 보여줄 대표이미지 하나, 상세페이지에서 보여줄 이미지들
	//s_(100x100) : 이미지 업로드한후 어떤 이미지를 업로드 했는지를 보여줄 때  이미지
	//reviewMain_(270x297) : 후기리스트에서 보여줄 메인 이미지
	//reviewDetail_(750x375) : 후기작성하고 후기상세페이지에서 보여줄 썸네일보다는 큰 이미지(여러장 있을 수도 있고 없을 수도 있다.)
	//marketMain_(588x406) : 메인페이지에 보여줄 마켓 대표이미지
	//marketDetail_(750x375) : 마켓 상세 보기에서 보여줄 이미지
	//marketItem_() : 각 마켓에서 판매될 이미지(각 아이템들의 크기가 정해져 있어야 할듯(gallary페이지의 사진정보 참조해서))
	//marketListMain_(270x297) : 마켓 모아보기 리스트에서 보여줄 마켓 이미지
	
	public ThumbnailMaker createMaker(String sort) {
		switch(sort) {
		case "relatedItem":
			return new ItemThnMaker();
		case "relatedMarket":
			return new MarketThnMaker();
		case "relatedReview":
			return new ReviewThnMaker();
		default:
			return null;
		}
	}
	
}
