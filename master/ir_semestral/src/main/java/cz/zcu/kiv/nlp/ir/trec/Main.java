package cz.zcu.kiv.nlp.ir.trec;

import cz.zcu.kiv.nlp.ir.trec.cli.ConsoleInterface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Scanner;

/**
 * Launcher class for the main application.
 */
public class Main {

    static Logger LOGGER = LoggerFactory.getLogger(Main.class);

    public static boolean running = true;

    public static void main(String[] args) {
        System.out.println(LOGGER.getName());

        ConsoleInterface con = new ConsoleInterface();
        Scanner stdin = new Scanner(System.in);
        String input = "";

        printGreeting();

        while (running) {
            System.out.print(">>> ");

            input = stdin.nextLine();
            if (input.equals(""))
                continue;

            con.processInput(input);
        }
    }

    private static void printGreeting() {
        System.out.println("This is a seminar project for Information Retrieval (KIV/IR). It is used interactively " +
                "through CLI. To see possible commands use 'help' or 'h'");
    }
}
