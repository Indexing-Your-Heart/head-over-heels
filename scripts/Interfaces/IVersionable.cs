namespace HeadOverHeels.Interfaces
{
    ///<summary> A super-interface that declares a class is uniquely identifiable (i.e., has a stable identity) and has
    /// a means to differentiate itself between other classes, described with a delta function. </summary>
    public interface IVersionable : IIdentifiable, IDifferentiable
    {

    }
}