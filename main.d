import std.stdio;
import std.random;
import std.conv;
import std.string : chomp;

enum Stats{attack = 5, defense = 5, intellect = 5, agility = 5}

struct enemy_id {
    string name;
    int health;
    int enattack;
    int endefense;
};

int roll6_dice() {
    return uniform(0,6);
}

int decision_table() {
    writeln(`1. Attack  2. Run`);
    string option = readln().chomp;
    int optint = to!int(option);
    if (optint == 1) {
        return roll6_dice + Stats.attack;
    } else if (optint == 2) {
        auto escapechance = uniform(0,100) + Stats.agility;
        if (escapechance < 50) {
            return 9000;
        } else {
            return 9001;
        }
    } else {
        return 9002;
    }
}

int enemy_attacks_you (enemy_id attackarg, int playerhealth) {
    writeln("The enemy attacks you!");
    playerhealth = uniform(0,6) + attackarg.enattack;
    return playerhealth;
}

void battle(enemy_id idarg, int playerhealth) {
    int battlehealth = idarg.health;
    auto attackarg = idarg;

    while (battlehealth > 0) {
        if (decision_table() == 9000) { // Maybe replace this with case/break?
            writeln("Your Escape was unsuccessful!");
            writeln(enemy_attacks_you(attackarg, playerhealth));
        } else if (decision_table() == 9001) {
            writeln("You Escaped!");
            battlehealth = 0;
        } else {
            writeln("You swung your sword at the enemy!"); //Add some randomizer for some custom messages!
            battlehealth = battlehealth - decision_table();
            writeln("Enemy Health is at: ", battlehealth);
            writeln(enemy_attacks_you(attackarg, playerhealth));
        }
    }
}

void main(string[] args) {
    enemy_id scorpion;
    scorpion.name = "Scorpion";
    scorpion.health = 50;
    scorpion.enattack = 5;
    scorpion.endefense = 1;
    auto idarg = scorpion;
    auto playerhealth = 100;
    battle(idarg, playerhealth);
}
