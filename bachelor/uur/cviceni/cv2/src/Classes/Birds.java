package Classes;

import Interfaces.commonInterface;
import Interfaces.eggInterface;
import Interfaces.soundInterface;

public abstract class Birds extends Animal implements commonInterface, eggInterface, soundInterface {
    public Birds(double x, double y, int energy, String name) {
        super(x, y, energy, name);
    }

    @Override
    public boolean layEggs() {
        return spendEnergy(5);
    }

    @Override
    public boolean cry() {
        return spendEnergy(1);
    }
}
