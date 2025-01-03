﻿using Cart.Service.DataAccess.Options;
using Microsoft.Extensions.Options;

namespace Cart.Service.Options;

[OptionsValidator]
public partial class ValidateMongoDbOptions : IValidateOptions<MongoDbOptions>
{
}
