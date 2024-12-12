using ApplicationCore.Outbox.Commands;

namespace API.Maintanance.OutboxEvents;

public class SendOutboxMessages(ILogger<SendOutboxMessages> logger, IMediator sender)
{
    [Function("SendOutboxMessages")]
    public async Task<IActionResult> Run([TimerTrigger("0 */20 * * * *")] TimerInfo myTimer)
    {
        logger.LogInformation("{FunctionName} was called", nameof(SendOutboxMessages));

        var command = new SendOutboxMessagesCommand();
        await sender.Send(command);

        if (myTimer.ScheduleStatus is not null)
            logger.LogInformation("Next timer schedule at: {NextScheduledTime}", myTimer.ScheduleStatus.Next);

        return new OkObjectResult(true);
    }
}
