using ApplicationCore.Categories.Commands.CreateCategory;
using ApplicationCore.Common.Exceptions;

namespace ApplicationCore.Test.Categories.Commands;

[TestFixture]
public class CreateCategoryTests
{
    private Fixture _fixture;
    private Mock<ICategoryRepository> _repositoryMock;

    [SetUp]
    public void Setup()
    {
        _fixture = new Fixture();
        _repositoryMock = new Mock<ICategoryRepository>();
    }

    private CreateCategoryCommandHandler CreateHandler()
        => new(_repositoryMock.Object);

    [Test]
    public async Task Handle_ShouldCreateCategory_WhenValidRequestWithoutParentId()
    {
        // Arrange
        var command = BuildCommandWithoutParentId();
        var category = BuildCategoryFromCommand(command);

        _repositoryMock
            .Setup(repo => repo.Add(It.IsAny<Category>(), It.IsAny<CancellationToken>()))
            .ReturnsAsync(category);

        var handler = CreateHandler();

        // Act
        var result = await handler.Handle(command, CancellationToken.None);

        // Assert
        result.Should().NotBeNull();
        result.Name.Should().Be(command.Name);
        result.Image.Should().Be(command.Image);
        result.ParentCategoryId.Should().BeNull();

        _repositoryMock.Verify(repo => repo.Add(It.IsAny<Category>(), It.IsAny<CancellationToken>()), Times.Once);
    }

    [Test]
    public async Task Handle_ShouldCreateCategory_WhenValidRequestWithParentId()
    {
        // Arrange
        var parentCategory = BuildCategoryFromCommand(new CreateCategoryCommand("root", "image.png", null));
        var command = BuildCommandWithParentId(parentCategory.Id);
        var category = BuildCategoryFromCommand(command, parentCategory.Id);

        _repositoryMock
            .Setup(repo => repo.Get(parentCategory.Id, It.IsAny<CancellationToken>()))
            .ReturnsAsync(parentCategory);

        _repositoryMock
            .Setup(repo => repo.Add(It.IsAny<Category>(), It.IsAny<CancellationToken>()))
            .ReturnsAsync(category);

        var handler = CreateHandler();

        // Act
        var result = await handler.Handle(command, CancellationToken.None);

        // Assert
        result.Should().NotBeNull();
        result.Name.Should().Be(command.Name);
        result.Image.Should().Be(command.Image);
        result.ParentCategoryId.Should().Be(parentCategory.Id);

        _repositoryMock.Verify(repo => repo.Get(parentCategory.Id, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.Add(It.IsAny<Category>(), It.IsAny<CancellationToken>()), Times.Once);
    }

    [Test]
    public void Handle_ShouldThrowEntityNotFoundException_WhenParentCategoryDoesNotExist()
    {
        // Arrange
        var command = BuildCommandWithParentId(1);

        _repositoryMock
            .Setup(repo => repo.Get(1, It.IsAny<CancellationToken>()))
            .ReturnsAsync((Category)null);

        var handler = CreateHandler();

        // Act & Assert
        FluentActions.Invoking(() => handler.Handle(command, CancellationToken.None))
            .Should().ThrowAsync<EntityNotFoundException>();

        _repositoryMock.Verify(repo => repo.Get(1, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.Add(It.IsAny<Category>(), It.IsAny<CancellationToken>()), Times.Never);
    }

    #region Helpers

    private CreateCategoryCommand BuildCommandWithoutParentId()
        => _fixture.Build<CreateCategoryCommand>()
                   .With(c => c.ParentCategoryId, (int?)null)
                   .Create();

    private CreateCategoryCommand BuildCommandWithParentId(int parentId)
        => _fixture.Build<CreateCategoryCommand>()
                   .With(c => c.ParentCategoryId, parentId)
                   .Create();

    private Category BuildCategoryFromCommand(CreateCategoryCommand command, int? parentId = null)
        => _fixture
            .Build<Category>()
            .With(c => c.Name, command.Name)
            .With(c => c.Image, command.Image)
            .With(c => c.ParentCategoryId, parentId)
            .Without(c => c.ParentCategory)
            .With(c => c.ChildCategories, [])
            .Create();

    #endregion
}
