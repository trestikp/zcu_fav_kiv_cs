package Classes;

public class Pigeon extends Birds {

    public Pigeon(double x, double y, int energy, String name) {
        super(x, y, energy, name);
    }

    @Override
    public void moveTo(double x, double y) {
        if(doMoveTo(x, y)) {
            System.out.println(this.getName() + " flies low to " + this.getPositionAsString());
        }
    }

    @Override
    public void eat(int restore) {
        if(doEat(restore)) {
            System.out.println(this.getName() + " ate grain and has " + this.getEnergy() + " (+" + restore + ")");
        }
    }

    @Override
    public boolean layEggs() {
        boolean res = super.layEggs();

        if(res) {
            System.out.println(this.getName() + " laid 2 eggs");
        } else {
            System.out.println(this.getName() + " doesn't have enough energy to lay eggs");
        }

        return res;
    }

    @Override
    public boolean cry() {
        boolean res = super.cry();

        if(res) {
            System.out.println(this.getName() + " beeped");
        } else {
            System.out.println(this.getName() + " is too tired to beep");
        }

        return res;
    }
}
