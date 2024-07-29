package Classes;

public class Animal {
    protected double x, y;
    protected int energy;
    protected final String name;

    public Animal(double x, double y, int energy, String name) {
        this.x = x;
        this.y = y;
        this.energy = energy;
        this.name = name;
    }

    /*****************************************************************
    *   Vyzadane metody                                              *
    *****************************************************************/
    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public int getEnergy() {
        return energy;
    }

    /*****************************************************************
     *   Pomocne metody                                              *
     *****************************************************************/

    public String getPositionAsString() {
        return String.format("%.2f", x) + ", " + String.format("%.2f", y);
    }

    public final String getName() {
        return name;
    }

    protected boolean doMoveTo(double x, double y) {
        if(energy < 1) {
            System.out.println(name + " doesn't have enough energy to move!");

            return false;
        } else {
            this.x = x;
            this.y = y;

            return true;
        }
    }

    protected boolean doEat(int restore) {
        if((energy + restore) > 0) {
            energy += restore;

            return  true;
        } else return false;
    }

    protected boolean spendEnergy(int amount) {
        if((energy - amount) < 0) return false;
        else {
            energy -= amount;
            return true;
        }
    }

    @Override
    public String toString() {
        return "Animal (" + this.getClass().getSimpleName() + ") " + name + " is at " +
                getPositionAsString() + " and has " + energy + " energy";
    }
}
