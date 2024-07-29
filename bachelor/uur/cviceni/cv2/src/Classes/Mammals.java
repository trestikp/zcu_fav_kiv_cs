package Classes;

import Interfaces.commonInterface;
import Interfaces.soundInterface;

public abstract class Mammals extends Animal implements commonInterface, soundInterface {
    public Mammals(double x, double y, int energy, String name) {
        super(x, y, energy, name);
    }

    @Override
    public boolean cry() {
        return spendEnergy(1);
    }
}
