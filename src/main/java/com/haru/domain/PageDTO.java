package com.haru.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {

	private int startPage; //ページの始まり
	private int endPage; //ページの最後
	private boolean prev,next; //以前、次のページがあるとtrue,ない場合false

	private int total; //データの全体の数
	private Criteria cri; //現在のページと画面に表示するページの数
	
	//constructorでフィルドメンバに代入
		public PageDTO(Criteria cri, int total) {
			this.cri = cri;
			this.total = total;
			
			//画面に表示するページの計算
			this.endPage = (int)(Math.ceil(cri.getPageNum()/5.0)*5);
			this.startPage = this.endPage -4;
			
			//全データの最後のページ
			int realEnd = getTotalPage();
			
			if(realEnd < endPage) this.endPage = realEnd;
			
			this.prev = this.startPage > 1;
			this.next = this.endPage < realEnd;
		}
		public int getTotalPage() {
			return (int)(Math.ceil((total*1.0)/cri.getAmount()));
		}
}
