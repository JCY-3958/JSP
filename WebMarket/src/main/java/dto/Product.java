package dto;

import java.io.Serializable;

public class Product implements Serializable{
	//UID 값을 지정하지 않으면 다른 변수의 값이 달라질 때 UID값이 일치하지 않아
	//객체를 사용하지 못하는 경우가 발생하여 고정
	private static final long serialVersionUID = -4274700572038677000L;
	
	//이거 그대로 데이터베이스에 들어감
	private String productId; // 상품 아이디
	private String pname; // 상품명
	private Integer unitPrice; // 상품 가격
	private String description; // 상품 설명
	private String manufacturer; // 제조사
	private String category; // 분류
	private long unitsInstock; // 재고 수
	private String condition; // 신상품 or 중고품 or 재생품
	private String filename; // 이미지 파일명
	
	//기본 생성자
	public Product() {
		super();
	}
	
	public Product(String productId, String pname, Integer unitPrice) {
		this.productId = productId;
		this.pname = pname;
		this.unitPrice = unitPrice;
	}

	//getter와 setter
	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public Integer getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public long getUnitsInStock() {
		return unitsInstock;
	}

	public void setUnitsInStock(long unisInstock) {
		this.unitsInstock = unisInstock;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}
	
	public String getFilename() {
		return filename;
	}
	
	public void setFilename(String filename) {
		this.filename = filename;
	}
}