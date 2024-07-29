package Classes;

public class Sloth extends Mammals {

    public Sloth(double x, double y, int energy, String name) {
        super(x, y, energy, name);
    }

    @Override
    public void moveTo(double x, double y) {
        if(doMoveTo(x, y)) {
            System.out.println(this.getName() + " crawled to " + this.getPositionAsString());
        }
    }

    @Override
    public void eat(int restore) {
        if(doEat(restore)) {
            System.out.println(this.getName() + " ate leaf and has " + this.getEnergy() + " (+" + restore + ")");
        }
    }

    @Override
    public boolean cry() {
        boolean res = super.cry();

        if(res) {
            System.out.println(this.getName() + " grumbled");
        } else {
            System.out.println(this.getName() + " is too tired to grumble");
        }

        return res;
    }
}
