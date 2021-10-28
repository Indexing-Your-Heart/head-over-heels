namespace HeadOverHeels.Interfaces
{
    ///<summary> An interface that declares a class has values that change over time and can be described with a delta
    /// function that determines how to reach from state of a class to another. </summary>
    public interface IDifferentiable
    {
        /// <summary> Returns information that describes how to update a class to another version of a class. </summary>
        /// <param name="other"> The starting class that will use the delta to reach the current class's state. </param>
        object Delta(IDifferentiable other);
    }
}