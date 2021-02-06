function Elements = getElements(DOMAIN)
%%GETELEMENTS 
%  INPUT:
%     -   DOMAIN :
%  OUTPUT:
%     -   functionElements:


    %MESH Creates a Fluid or Structure Mesh
    %   Structures Mesh :  Uses a 1D Mesh with nDofNode DOF's
    %   Fluid Mesh : Uses a Quadrilateral element with 4 Nodes and 4 DOFS

    Elements = DOMAIN.Elements;
     
    switch DOMAIN.Elements.ElementType
    
        case "Beam"
        Elements.DOFperElement = 4;
        Elements.DOFperNode = 2;
        Elements.NodeperElement = 2;



        case "Quadrilateral"
        Elements.DOFperElement = 4;
        Elements.DOFperNode = 1;
        Elements.NodeperElement = 4;
        
    end
       
end