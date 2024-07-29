package delivery;

import java.util.LinkedList;

import objects.Mansion;

/**
 * Class of order
 * @author Pavel Trestik a Tomas Ott
 */
public class Order {

	public static LinkedList<Order> manualOrders= new LinkedList<Order>();
	
	
	/** Number of all orders */
	public static int numberOfAllOrders =0;

	/** Instance of the subscriber of the order */
	private final Mansion subscriber;
	/** Amount of pallets ordered */
	private int amount;
	/** Number(id) of order */
	public int orderNum=0;
	/** Expected time of delivery in min */
	private int probableDeliveryInMin=0;

	private boolean manual = false;
	
	/**
	 * Constructor of the order
	 * @param sub mansion creating the order
	 * @param am amount of pallets to be ordered
	 */
	public Order(Mansion sub, int am, boolean manual) {
		this.subscriber=sub;
		this.amount=am;
		numberOfAllOrders++;
		this.orderNum= numberOfAllOrders;
		this.manual=manual;
		if(manual) {
			manualOrders.add(this);
			System.out.print("MANUAL ");
		}
		System.out.println("Order n: "+orderNum+" for "+am+" pallet has been made by mansion n: " + subscriber.iD + "!");
	}

	/**
	 * Method sets probable time of delivery
	 * @param timeInMin expected new time
	 */
	public void setProbableTime(int timeInMin) {
		this.probableDeliveryInMin=timeInMin;
	}

	/**
	 * Method returns probable time of delivery
	 * @return time in min
	 */
	public int getProbableTime() {
		return this.probableDeliveryInMin;
	}


	/**
	 * Getter of the amount of pallets
	 * @return amount
	 */
	public int getAmount() {
		return amount;
	}

	/**
	 * Getter of the mansion creating order
	 * @return mansion
	 */
	public Mansion getSubscriber() {
		return subscriber;
	}

	/**
	 * Method to give information about the order in text from.
	 * @return string
	 */
	@Override
	public String toString(){
		if(manual){
			return "	MANUAL ORDER: " + orderNum + ", by mansion: " + subscriber.iD + ", amount: " + amount + " pallets";
		} else {
			return "	Order: " + orderNum + ", by mansion: " + subscriber.iD + ", amount: " + amount + " pallets";
		}
	}
}
