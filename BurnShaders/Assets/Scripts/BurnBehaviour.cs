using UnityEngine;
using System.Collections;

namespace BurnShaders
{
    public class BurnBehaviour : MonoBehaviour
    {
        [Header("Textures")]
        public Texture2D[] imageTextures;
        public Texture2D[] burnPatterns;

        [Space(10)]
        public UnityEngine.UI.Slider timeSlider;

        public Material burnMaterial;

        private float progress;
        bool isBurning;

        void Start()
        {
            timeSlider.value = 0.5F;

            SelectImage(0);
            SetBurnPattern(0);

            UnBurn();
        }

        void Update()
        {
            if (isBurning && progress <= 1)
            {
                float duration = 100 + (4900 * timeSlider.value);

                progress +=  Time.deltaTime*1000 / duration;
                burnMaterial.SetFloat("_BurnAmount", progress);
            }
        }

        public void SelectImage(int index)
        {
            burnMaterial.SetTexture("_MainTex", imageTextures[index]);
            UnBurn();
        }

        public void SetBurnPattern(int index)
        {
            burnMaterial.SetTexture("_BurnTex", burnPatterns[index]);
            UnBurn();
        }

        public void Burn()
        {
            UnBurn();
            isBurning = true;
        }

        private void UnBurn()
        {
            progress = 0;
            isBurning = false;
            burnMaterial.SetFloat("_BurnAmount", 0);
        }
    }
}
