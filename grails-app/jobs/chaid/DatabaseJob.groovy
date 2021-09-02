package chaid

class DatabaseJob {
    static triggers = {
    //  simple repeatInterval: 5000l // execute job once in 5 seconds
        cron name: 'myTrigger', cronExpression: "0 0 22 * * ?"
    }

    def execute() {
       // println("Called ")
        // execute job


        println("passed")

    }
}
