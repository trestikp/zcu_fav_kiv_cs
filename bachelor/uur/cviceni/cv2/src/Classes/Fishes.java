package Classes;

import Interfaces.commonInterface;
import Interfaces.eggInterface;

public abstract class Fishes extends Animal implements commonInterface, eggInterface {
    public Fishes(double x, double y, int energy, String name) {
        super(x, y, energy, name);
    }

    @Override
    public boolean layEggs() {
        return spendEnergy(5);
    }
}
