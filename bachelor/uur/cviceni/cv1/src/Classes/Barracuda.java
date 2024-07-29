package Classes;

public class Barracuda extends Fishes {

    public Barracuda(double x, double y, int energy, String name) {
        super(x, y, energy, name);
    }

    @Override
    public void moveTo(double x, double y) {
        if(doMoveTo(x, y)) {
            System.out.println(this.getName() + " swam deep to " + this.getPositionAsString());
        }
    }

    @Override
    public void eat(int restore) {
        if(doEat(restore)) {
            System.out.println(this.getName() + " ate meat and has " + this.getEnergy() + " (+" + restore + ")");
        }
    }

    @Override
    public boolean layEggs() {
        boolean res = super.layEggs();

        if(res) {
            System.out.println(this.getName()+  " laid 1000 eggs");
        } else {
            System.out.println(this.getName() + " doesn't have enough energy to lay eggs");
        }

        return res;
    }
}
